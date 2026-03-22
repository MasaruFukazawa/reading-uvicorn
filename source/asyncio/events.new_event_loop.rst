events.new_event_loop
===========================

実装
---------------------------

.. code-block:: python

    def new_event_loop():
        """Equivalent to calling get_event_loop_policy().new_event_loop()."""
        return get_event_loop_policy().new_event_loop()


引数
---------------------------

- なし

戻り値
---------------------------

- 生成されたイベントループ

内容
---------------------------

- 新しくイベントループを生成し、返却する

    - get_event_loop_policy : _UnixDefaultEventLoopPolicy を返す
    - new_event_loop : _UnixDefaultEventLoopPolicy.new_event_loop を呼び出す

        - 


.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:

   events.get_event_loop_policy
   unix_events._UnixDefaultEventLoopPolicy.new_event_loop
