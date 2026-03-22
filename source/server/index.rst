Server クラス
===========================

.. list-table::
   :widths: 20 80

   * - File Path
     - uvicorn/server.py


__init__ メソッド
----------------

.. code-block:: python

    def __init__(self, config: Config) -> None:
        self.config = config
        self.server_state = ServerState()

        self.started = False
        self.should_exit = False
        self.force_exit = False
        self.last_notified = 0.0

**内容**


**引数**


**戻り値**


startup メソッド
----------------

.. code-block:: python

    async def startup(self, sockets: list[socket.socket] | None = None) -> None:
        await self.lifespan.startup()
        if self.lifespan.should_exit:
            self.should_exit = True
            return

        config = self.config

        def create_protocol(
            _loop: asyncio.AbstractEventLoop | None = None,
        ) -> asyncio.Protocol:
            return config.http_protocol_class(  # type: ignore[call-arg]
                config=config,
                server_state=self.server_state,
                app_state=self.lifespan.state,
                _loop=_loop,
            )

        loop = asyncio.get_running_loop()

        listeners: Sequence[socket.SocketType]
        if sockets is not None:
            # Explicitly passed a list of open sockets.
            # We use this when the server is run from a Gunicorn worker.

            def _share_socket(
                sock: socket.SocketType,
            ) -> socket.SocketType:  # pragma py-linux pragma: py-darwin
                # Windows requires the socket be explicitly shared across
                # multiple workers (processes).
                from socket import fromshare  # type: ignore[attr-defined]

                sock_data = sock.share(os.getpid())  # type: ignore[attr-defined]
                return fromshare(sock_data)

            self.servers: list[asyncio.base_events.Server] = []
            for sock in sockets:
                is_windows = platform.system() == "Windows"
                if config.workers > 1 and is_windows:  # pragma: py-not-win32
                    sock = _share_socket(sock)  # type: ignore[assignment]
                server = await loop.create_server(
                    create_protocol, sock=sock, ssl=config.ssl, backlog=config.backlog
                )
                self.servers.append(server)
            listeners = sockets

        elif config.fd is not None:  # pragma: py-win32
            # Use an existing socket, from a file descriptor.
            sock = socket.fromfd(config.fd, socket.AF_UNIX, socket.SOCK_STREAM)
            server = await loop.create_server(
                create_protocol, sock=sock, ssl=config.ssl, backlog=config.backlog
            )
            assert server.sockets is not None  # mypy
            listeners = server.sockets
            self.servers = [server]

        elif config.uds is not None:  # pragma: py-win32
            # Create a socket using UNIX domain socket.
            uds_perms = 0o666
            if os.path.exists(config.uds):
                uds_perms = os.stat(config.uds).st_mode
            server = await loop.create_unix_server(
                create_protocol, path=config.uds, ssl=config.ssl, backlog=config.backlog
            )
            os.chmod(config.uds, uds_perms)
            assert server.sockets is not None  # mypy
            listeners = server.sockets
            self.servers = [server]

        else:
            # Standard case. Create a socket from a host/port pair.
            try:
                server = await loop.create_server(
                    create_protocol,
                    host=config.host,
                    port=config.port,
                    ssl=config.ssl,
                    backlog=config.backlog,
                )
            except OSError as exc:
                logger.error(exc)
                await self.lifespan.shutdown()
                sys.exit(1)

            assert server.sockets is not None
            listeners = server.sockets
            self.servers = [server]

        if sockets is None:
            self._log_started_message(listeners)
        else:
            # We're most likely running multiple workers, so a message has already been
            # logged by `config.bind_socket()`.
            pass

        self.started = True

**内容**

以下の4つのパターンのいずれかでサーバの生成を行う

- 生成済みのソケットが渡されている場合

    - 読み飛ばし

- Unixソケット（ファイルディスクリプタ）の場合

    - 読み飛ばし

- UNIX domain socketの場合

    - 読み飛ばし

- ソケットを生成してサーバを作成する場合

**引数**

- sockets: list[socket.socket] : 生成済みのソケット

**戻り値**

- None