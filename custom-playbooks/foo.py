from robusta.api import *


@action
def foo(event: EventEvent):
    print(f"foo eventent ={event}")
