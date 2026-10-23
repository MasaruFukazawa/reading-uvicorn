events._init_event_loop_policy
===========================

実装
---------------------------

**asyncio.events._init_event_loop_policy**

.. code-block:: python

    def _init_event_loop_policy():
        global _event_loop_policy
        with _lock:
            if _event_loop_policy is None:  # pragma: no branch
                from . import DefaultEventLoopPolicy
                _event_loop_policy = DefaultEventLoopPolicy()


**asyncio.__init__**

.. code-block:: python

    if sys.platform == 'win32':  # pragma: no cover
        from .windows_events import *
        __all__ += windows_events.__all__
    else:
        from .unix_events import *  # pragma: no cover
        __all__ += unix_events.__all__


引数
---------------------------

- なし

戻り値
---------------------------

- イベントループポリシー

内容
---------------------------



.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:

   unix_events._UnixDefaultEventLoopPolicy.__init__