要求：
对给定产生式所描述的文法进行输入符号串的识别（采用预测分析法）。
1、简单：产生式文法采用教材P109页中的例题，first和follow集由人工计算，程序中直
接指定，如果结果是识别成功，则输出Yes，否则输出No。
2、复杂：产生式由文件输入，程序中计算first和follow集，其余与上面简单要求相同。

使用：
top_down_forecast_analysis 产生式文件 输入字符串#

实现：
1、本份代码使用了简单要求，将书上例题中的产生式的first和follow集直接初始化到程序中。
2、在构建分析栈以及压栈的时候，使用了头插法建立的链式结构，其可以动态地识别符号串。
