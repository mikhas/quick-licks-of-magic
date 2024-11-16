Code examples for application programming with QML & Python
===========================================================

Companion repository of [this blog](https://quitemeticulouslogic.com).

Each example is self-contained and features a particular pattern or an elegant
solution to a common problem. If the code isn't self-explanatory then visit the
specific blog post linked in each code example's `README.md` for more
information.


List of examples
----------------

- [src/app-template](src/app-template)
- [src/qml-properties](src/qml-properties)
- [src/qml-factory](src/qml-factory)
- [src/qml-actions](src/qml-actions)
- [src/qml-action-decorator](src/qml-action-decorator)
- [src/qml-zoomable-image](src/qml-zoomable-image)


How to run the examples
-----------------------

Create a Python environment and install PySide6:

```
$ cd path/to/my/project
$ python3 -m venv env
$ . ./env/bin/activate
$ (env) pip install PySide6
```

Then run any example like so:

```
$ (env) cd path/to/example
$ (env) python3 main.py
```
