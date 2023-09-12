Lua：表
========

本节中我们介绍Lua的另一个重要概念——表。表是一种可以将各种相关信息关联在一起的结构。

这次，我们把一开始讲列表时的代码改一改：

.. code:: lua

   local generals = { xusheng = "徐盛", ganning = "甘宁" }

这样，我们便构造了一个表，但有所不同，这个表将不再能通过编号查询元素，但它可以通过等号前的字符查找到对应的元素。

.. code:: lua

   local generals = { xusheng = "徐盛", ganning = "甘宁" }
   print(generals[1])  -- nil
   print(generals["xusheng"])  -- 徐盛

像这样一个“键”对应一个“值”的结构就称为表。平时大家也叫他哈希表。

表的构造和访问
-----------------

在Lua中，表是一系列\ `键 = 值`\ 对（下文称键值对）的集合。每个键都关联一个值，或者说，键和其他变量一样是可以被赋值的。
我们还可以扩写上文定义的表：

.. code:: lua

   local generals = { xusheng = "徐盛", ganning = "甘宁", guojia = "郭嘉" }
   generals["huangzhong"] = "黄忠"
   print(generals["guojia"])  -- 打印出“郭嘉”
   print(generals["huangzhong"])  -- 打印出“黄忠”

添加键值对
~~~~~~~~~~~~~~~~~~~~~~~~~~

你可以随时给表加键值对，只需要依次指定字典名、用方括号括起的键和相关联的值即可。

例如我们定义一个武将：

.. code:: lua

   local general = { name = "徐盛", skill = "破军" }

但是一个武将必须有体力值和体力值上限，所以这时候我们就可以给它补上：

.. code-block:: lua
   :emphasize-lines: 2,3

   local general = { name = "徐盛", skill = "破军" }
   general["maxHp"] = 4
   general["hp"] = 4

这样就可以给这个武将加上新的参数了。
最后再访问这个武将的\ ``maxHp``\ 就不会返回nil，而是返回4了。

空表与删除键值对
~~~~~~~~~~~~~~~~~~~~~~~~~~

Lua是很自由的语言，未声明的变量被使用前的那一瞬间就会被自动声明，所以Lua永远都没有“\ **未声明变量**\ ”。

同理，也从来没有“\ **未定义的键值对**\ ”，因为你随便用什么键访问表，哪怕是没定义的键也会给你返回nil。
所以想删除键值对，只需要把这个键对应的值设为nil即可。

例如国战的某位现在要移除副将：

.. code-block:: lua
   :linenos:
   :emphasize-lines: 3,8

   local general1 = { name = "徐盛", skill = "破军" }
   local general2 = { name = "甘宁", skill = "奇袭" }
   local role1 = { general = general1, sub_general = general2 }
   print(role1.general.name) -- 打印出“徐盛”
   print(role1.sub_general.name) -- 打印出“甘宁”

   --移除副将时
   role1.sub_general = nil

   print(role1.general.name) -- 打印出“徐盛”
   print(role1.sub_general.name) -- 报错，因为sub_general已经被设为nil了

.. hint::

   一个键对应的值可以是任何东西，甚至包括函数（参考创建技能时输入的表）

.. hint::

   实际代码中，我们一般使用更简洁的\ ``表.键``\ 来访问一个键的值，这也是访问一个对象的参数的方法。


遍历键值对
~~~~~~~~~~~~~~~~~~~~

类似于列表，我们也可以用for语句来遍历表的每一个键值对，但是要稍作修改。

.. code-block:: lua

   local general = { name = "孙策", skill = {"激昂", "魂姿", "制霸"}, relative = {"英魂", "英姿"} }
   for k, v in pairs(general) do
      print(k, v)
   end

运行上面的代码，它并没有按照键值的顺序输出，而是一种无序化的，这与表的内部实现有关。
大家只要记住ipairs用来遍历列表，pairs用来遍历表就行了。
