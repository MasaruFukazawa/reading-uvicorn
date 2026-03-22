unix_events._UnixDefaultEventLoopPolicy.new_event_loop
===========================

実装
---------------------------

.. code-block:: python

    class _UnixDefaultEventLoopPolicy(events.BaseDefaultEventLoopPolicy):
        """UNIX event loop policy with a watcher for child processes."""
        _loop_factory = _UnixSelectorEventLoop


継承元
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

        def new_event_loop(self):
            """Create a new event loop.

            You must call set_event_loop() to make this the current event
            loop.
            """
            return self._loop_factory()

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

.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:

   unix_events._UnixSelectorEventLoop.__init__

