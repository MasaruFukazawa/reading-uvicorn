print_version 関数
===========================

.. list-table::
   :widths: 20 80

   * - File Path
     - uvicorn/main.py


実装
---------------------------

.. code-block:: python

    def print_version(ctx: click.Context, param: click.Parameter, value: bool) -> None:
        if not value or ctx.resilient_parsing:
            return
        click.echo(
            "Running uvicorn %s with %s %s on %s"
            % (
                uvicorn.__version__,
                platform.python_implementation(),
                platform.python_version(),
                platform.system(),
            )
        )
        ctx.exit()


引数
---------------------------

- 


戻り値
---------------------------

- 


内容
---------------------------

- 

.. toctree::
   :maxdepth: 1
   :caption: 呼び出し関数:


