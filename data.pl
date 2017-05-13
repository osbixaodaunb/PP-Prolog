%% data.pl
/* training set */
student(1, approve, [pre_vest=yes, period=morning, sex=f, preference=exact]).
student(2, reject, [pre_vest=no, period=morning, sex=f, preference=humanities]).
student(3, approve, [pre_vest=yes, period=morning, sex=m, preference=exact]).
student(4, approve, [pre_vest=yes, period=afternoon, sex=f, preference=humanities]).
student(6, approve, [pre_vest=yes, period=morning, sex=f, preference=humanities]).
student(7, approve, [pre_vest=yes, period=morning, sex=f, preference=exact]).
student(8, approve, [pre_vest=yes, period=morning, sex=m, preference=exact]).
student(11, reject, [pre_vest=no, period=morning, sex=m, preference=humanities]).
/* test set */
test(5, reject, [pre_vest=yes, period=afternoon, sex=f, preference=exact]).
test(9, approve, [pre_vest=yes, period=morning, sex=m, preference=humanities]).
test(10, approve, [pre_vest=yes, period=morning, sex=m, preference=humanities]).
test(12, reject, [pre_vest=no, period=afternoon, sex=f, preference=humanities]).
