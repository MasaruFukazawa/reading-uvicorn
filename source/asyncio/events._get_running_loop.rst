events._get_running_loop
===========================

実装
---------------------------

.. code-block:: python

    # A TLS for the running event loop, used by _get_running_loop.
    class _RunningLoop(threading.local):
        loop_pid = (None, None)

    _running_loop = _RunningLoop()

    def _get_running_loop():
        """Return the running event loop or None.

        This is a low-level function intended to be used by event loops.
        This function is thread-specific.
        """
        # NOTE: this function is implemented in C (see _asynciomodule.c)
        running_loop, pid = _running_loop.loop_pid
        if running_loop is not None and pid == os.getpid():
            return running_loop

引数
---------------------------

- なし

戻り値
---------------------------

- なし

内容
---------------------------

- **import asyncio** したタイミングで、 **_RunningLoop** のインスタンス生成を行う

    - 

- runners.run 関数から初回呼び出しされた時は、None を返す