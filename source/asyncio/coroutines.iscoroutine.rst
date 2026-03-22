coroutines.iscoroutine
===========================

実装
---------------------------

.. code-block:: python

    _COROUTINE_TYPES = (types.CoroutineType, types.GeneratorType,
                        collections.abc.Coroutine, CoroWrapper)

    _iscoroutine_typecache = set()

    def iscoroutine(obj):
        """Return True if obj is a coroutine object."""
        if type(obj) in _iscoroutine_typecache:
            return True

        if isinstance(obj, _COROUTINE_TYPES):
            # Just in case we don't want to cache more than 100
            # positive types.  That shouldn't ever happen, unless
            # someone stressing the system on purpose.
            if len(_iscoroutine_typecache) < 100:
                _iscoroutine_typecache.add(type(obj))
            return True
        else:
            return False

引数
---------------------------

- obj :

戻り値
---------------------------

- Boolean

内容
---------------------------

- 引数で渡されたオブジェクトが、コルーチンであるかを判定

    - True : コルーチン
    - False : Not コルーチン