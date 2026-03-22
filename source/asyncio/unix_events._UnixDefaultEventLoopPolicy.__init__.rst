unix_events._UnixDefaultEventLoopPolicy.__init__
===========================

実装
---------------------------

.. code-block:: python

    class _UnixDefaultEventLoopPolicy(events.BaseDefaultEventLoopPolicy):
        """UNIX event loop policy with a watcher for child processes."""
        _loop_factory = _UnixSelectorEventLoop

        def __init__(self):
            super().__init__()
            self._watcher = None
    
    DefaultEventLoopPolicy = _UnixDefaultEventLoopPolicy


引数
---------------------------

- なし

戻り値
---------------------------

- イベントループポリシー

内容
---------------------------

- 
- 

継承元
---------------------------

.. code-block:: python

    class BaseDefaultEventLoopPolicy(AbstractEventLoopPolicy):
        """Default policy implementation for accessing the event loop.

        In this policy, each thread has its own event loop.  However, we
        only automatically create an event loop by default for the main
        thread; other threads by default have no event loop.

        Other policies may have different rules (e.g. a single global
        event loop, or automatically creating an event loop per thread, or
        using some other notion of context to which an event loop is
        associated).
        """

        _loop_factory = None

        class _Local(threading.local):
            _loop = None
            _set_called = False

        def __init__(self):
            self._local = self._Local()

        #
        # つづくよ
        #

.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:

