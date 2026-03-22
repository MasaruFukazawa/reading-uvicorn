runners.run
===========================

実装
---------------------------

.. code-block:: python

    def run(main, *, debug=False):
        """Run a coroutine.

        This function runs the passed coroutine, taking care of
        managing the asyncio event loop and finalizing asynchronous
        generators.

        This function cannot be called when another asyncio event loop is
        running in the same thread.

        If debug is True, the event loop will be run in debug mode.

        This function always creates a new event loop and closes it at the end.
        It should be used as a main entry point for asyncio programs, and should
        ideally only be called once.

        Example:

            async def main():
                await asyncio.sleep(1)
                print('hello')

            asyncio.run(main())
        """
        if events._get_running_loop() is not None:
            raise RuntimeError(
                "asyncio.run() cannot be called from a running event loop")

        if not coroutines.iscoroutine(main):
            raise ValueError("a coroutine was expected, got {!r}".format(main))

        loop = events.new_event_loop()
        try:
            events.set_event_loop(loop)
            loop.set_debug(debug)
            return loop.run_until_complete(main)
        finally:
            try:
                _cancel_all_tasks(loop)
                loop.run_until_complete(loop.shutdown_asyncgens())
            finally:
                events.set_event_loop(None)
                loop.close()


引数
---------------------------

- main : **async def**  で定義したコルーチン

戻り値
---------------------------

- 

内容
---------------------------

- **loop = events.new_event_loop()**

    - Not Windows 環境だと、_UnixSelectorEventLoop のインスタンスが帰ってくる

.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:

   events._get_running_loop
   coroutines.iscoroutine
   events.new_event_loop