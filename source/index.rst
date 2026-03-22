.. uvicornを読む documentation master file, created by
   sphinx-quickstart on Thu Mar 19 19:48:55 2026.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

uvicornを読む
===========================

.. list-table::
   :widths: 20 80

   * - Github URL
     - https://github.com/Kludex/uvicorn
   * - DeepWiki URL
     - https://deepwiki.com/Kludex/uvicorn

シーケンス図
--------------

.. mermaid::

   sequenceDiagram
      participant main.py
      participant Config
      participant Server
      participant asyncio

      main.py->>main.py: main()
      main.py->>main.py: run(app, host, port, ...)
      main.py->>Config: Config(app, host, port, ...)
      Config-->>main.py: config
      main.py->>Server: Server(config=config)
      main.py->>Server: server.run()
      Server->>Config: config.setup_event_loop()
      Server->>asyncio: asyncio.run(self.serve(...))
      asyncio->>Server: serve(sockets=sockets)
      Server->>Config: config.lifespan_class(config)
      Config-->>Server: 戻り値
      Server->>Server: self.install_signal_handlers()
      Server->>Server: self.startup(sockets=sockets)
      Server->>Server: self.main_loop()
      Server->>Server: self.shutdown(sockets=sockets)

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   config/index
   server/index


asyncioを読む
===========================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   asyncio/index
