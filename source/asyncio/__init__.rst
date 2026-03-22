__init__ 
===========================

実装
---------------------------

.. code-block:: python

    """The asyncio package, tracking PEP 3156."""

    # flake8: noqa

    import sys

    # This relies on each of the submodules having an __all__ variable.
    from .base_events import *
    from .coroutines import *
    from .events import *
    from .futures import *
    from .locks import *
    from .protocols import *
    from .runners import *
    from .queues import *
    from .streams import *
    from .subprocess import *
    from .tasks import *
    from .transports import *

    __all__ = (base_events.__all__ +
            coroutines.__all__ +
            events.__all__ +
            futures.__all__ +
            locks.__all__ +
            protocols.__all__ +
            runners.__all__ +
            queues.__all__ +
            streams.__all__ +
            subprocess.__all__ +
            tasks.__all__ +
            transports.__all__)

    if sys.platform == 'win32':  # pragma: no cover
        from .windows_events import *
        __all__ += windows_events.__all__
    else:
        from .unix_events import *  # pragma: no cover
        __all__ += unix_events.__all__


引数
---------------------------

- 

戻り値
---------------------------

- 

内容
---------------------------

- **import async** で、asyncフォルダ内のファイルに定義しているクラスなどを呼び出せるようにしている
- 実行環境 によって、使えるイベントループの出し分けをしている