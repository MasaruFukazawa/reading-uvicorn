events.get_event_loop_policy
===========================

実装
---------------------------

.. code-block:: python

    _event_loop_policy = None

    def get_event_loop_policy():
        """Get the current event loop policy."""
        if _event_loop_policy is None:
            _init_event_loop_policy()
        return _event_loop_policy

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

   events._init_event_loop_policy