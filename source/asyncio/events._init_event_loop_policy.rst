events._init_event_loop_policy
===========================

実装
---------------------------

.. code-block:: python

    def _init_event_loop_policy():
        global _event_loop_policy
        with _lock:
            if _event_loop_policy is None:  # pragma: no branch
                from . import DefaultEventLoopPolicy
                _event_loop_policy = DefaultEventLoopPolicy()

引数
---------------------------

- なし

戻り値
---------------------------

- イベントループポリシー

内容
---------------------------

- Windows 以外の場合、 **from .unix_events import *** する
- 

.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:

   unix_events._UnixDefaultEventLoopPolicy.__init__