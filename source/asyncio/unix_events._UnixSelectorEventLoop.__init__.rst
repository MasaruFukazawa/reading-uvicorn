unix_events._UnixSelectorEventLoop.__init__
===========================

実装
---------------------------

.. code-block:: python

    class _UnixSelectorEventLoop(selector_events.BaseSelectorEventLoop):
        """Unix event loop.

        Adds signal handling and UNIX Domain Socket support to SelectorEventLoop.
        """

        def __init__(self, selector=None):
            super().__init__(selector)
            self._signal_handlers = {}


継承元
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

    class BaseEventLoop(events.AbstractEventLoop):

        def __init__(self):
            self._timer_cancelled_count = 0
            self._closed = False
            self._stopping = False
            self._ready = collections.deque()
            self._scheduled = []
            self._default_executor = None
            self._internal_fds = 0
            # Identifier of the thread running the event loop, or None if the
            # event loop is not running
            self._thread_id = None
            self._clock_resolution = time.get_clock_info('monotonic').resolution
            self._exception_handler = None
            self.set_debug(coroutines._is_debug_mode())
            # In debug mode, if the execution of a callback or a step of a task
            # exceed this duration in seconds, the slow callback/task is logged.
            self.slow_callback_duration = 0.1
            self._current_handle = None
            self._task_factory = None
            self._coroutine_origin_tracking_enabled = False
            self._coroutine_origin_tracking_saved_depth = None

            # A weak set of all asynchronous generators that are
            # being iterated by the loop.
            self._asyncgens = weakref.WeakSet()
            # Set to True when `loop.shutdown_asyncgens` is called.
            self._asyncgens_shutdown_called = False

    class BaseSelectorEventLoop(base_events.BaseEventLoop):
        """Selector event loop.

        See events.EventLoop for API specification.
        """

        def __init__(self, selector=None):
            super().__init__()

            if selector is None:
                selector = selectors.DefaultSelector()
            logger.debug('Using selector: %s', selector.__class__.__name__)
            self._selector = selector
            self._make_self_pipe()
            self._transports = weakref.WeakValueDictionary()

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

