//
//  JHGCDViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 16/8/9.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "SJHRootViewController.h"

@interface SJHRootViewController ()

@end

@implementation SJHRootViewController




- (IBAction)serialqueueButtonDidClicked:(UIButton *)sender {
    
//    serial queue串行队列特点：
//    1、第一个任务执行完毕，第二个猜可以开始。以此类推。一个任务要开始必须要等到上一个任务结束。
//    2、串行队列有两种获取方式
    /*
//    《1》第一种获取方式里面的任务是主线程依次去执行
    dispatch_queue_t queue = dispatch_get_main_queue();
//    往队列里面添加任务
    dispatch_async(queue, ^{

        NSLog(@"这是第一个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);

    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第二个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第3个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第4个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第5个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第6个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第7个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    
    */
//    《2》获取串行队列的第二种方式  实质上是创建自己的队列  第一个参数是队列的名字（苹果推荐使用反向域名去命名，第二个参数是队列的类型（串行队列，并行队列））  这种方式创建的队列它会自己去开辟一个子线程去完成队列里面的任务
    
    dispatch_queue_t queue = dispatch_queue_create("com.shenjinghao.mySerialQueue", DISPATCH_QUEUE_SERIAL);
    
//    往队列里面添加任务
    
    dispatch_async(queue, ^{
        
        NSLog(@"这是第1个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第2个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第3个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第4个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第5个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第6个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    dispatch_async(queue, ^{
        
        NSLog(@"这是第7个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        
    });
    
    
}

//并行队列  concurrent queue  特点：第一个任务开始执行后  第二个不等第一个任务执行完毕就开始执行，以此类推  后面任务的执行跟前面没有关系。先执行的任务不一定先执行完。最后执行的任务也不一定最后执行完。并行队列会根据队里里面的任务数量  CPU使用情况  内存的消耗情况 ，开辟最合适的线程数量去完成队列里面的任务。

- (IBAction)concurrentqueueButtonDidClicked:(UIButton *)sender {
    
//    并行队列也有两种创建方式⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
//    <1>第一种方式
//    global queue 是苹果里面的全局队列 （总共三个全局队列），都是并发的队列  每个队列有4个优先级
//    DISPATCH_QUEUE_PRIORITY_DEFAULT
//    DISPATCH_QUEUE_PRIORITY_BACKGROUND
//    DISPATCH_QUEUE_PRIORITY_HIGH
//    DISPATCH_QUEUE_PRIORITY_LOW
//    第一个参数就是队列的优先级  第二个是苹果的预留的参数，为了以后去使用，目前没有用到，填写0
    /*
    dispatch_queue_t oneQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第1个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第2个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第3个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第4个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第5个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第6个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第7个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(oneQueue, ^{
        NSLog(@"这是第8个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    */
//    <2>第二种并发队列
    dispatch_queue_t twoQueue = dispatch_queue_create("com.lanou3g.myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(twoQueue, ^{
        dispatch_queue_t twoQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第1个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第2个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第3个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第4个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第5个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第6个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第7个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
        dispatch_async(twoQueue, ^{
            NSLog(@"这是第8个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
        });
    });
    
}

- (IBAction)afterButtonDidClicked:(UIButton *)sender {
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//            NSLog(@"这是第1个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
//
//    });
    
    
//    dispatch_after可以在任何队列去执行，串行和并行都可以
//    设置延迟时间
    dispatch_time_t decades = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
//    创建一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(decades, queue, ^{
        
            NSLog(@"这是第1个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);

    });
    
}

- (IBAction)groupButtonDidClicked:(UIButton *)sender {
    
//    dispatch_group_t主要用于把一些不想关的任务归为一组，组里面放的是队列
//    dispatch_group_async作用是往组里面的队列添加任务
//    dispatch_group_notify 作用是监听组里面的任务 ，等到组里面的任务全部执行完成之后，才会执行它里面的任务
    
//    1、创建队列 默认default（high和low还有后台优先级待定）
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    2、创建组
    dispatch_group_t group = dispatch_group_create();
//    3、往组里添加任务
    dispatch_group_async(group, queue, ^{
        NSLog(@"这是第一个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"这是第2个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"这是第3个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"我是最后一个任务，组里面的其他任务都执行完毕之后，我就会执行");
        
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"这是第4个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"这是第5个任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    
}


- (IBAction)onceButtonDidClecked:(UIButton *)sender {
    
//    下面的方法能够保证代码只执行一次，而且能够保证线程的安全。⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"执行");
    });
    
}

- (IBAction)sameReadAndWriteButton:(UIButton *)sender {
    
//    数据库的读取。。可以并发执行   通过GCD里面的并行队列去实现
//    数据库的写入。。。只能串行执行   通过GCD里面的串行队列去实现
//    但是真正的项目  肯定既有数据的读取  也有数据库的写入
//    解决方法
//    dispatch_barrier_async在他之前的任务可以并发去执行 在他之后的任务也可以去并发执行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
         NSLog(@"这是第1个读取数据库的任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"这是第2个读取数据库的任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"这是第3个读取数据库的任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    
//    防止出现垃圾数据
    dispatch_barrier_async(queue, ^{
        NSLog(@"我再写东西，非诚勿扰");
    });
    dispatch_async(queue, ^{
        NSLog(@"这是第4个读取数据库的任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"这是第5个读取数据库的任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"这是第6个读取数据库的任务 , 当前线程是%@ 是否主线程：%d",[NSThread currentThread],[NSThread isMainThread]);
    });
    
}

- (IBAction)manyTimeAplyButtonDidclicked:(UIButton *)sender {
//    第一个参数：执行的次数  第二个参数 ：在哪个队列里执行
//    具体的实现
    
//    dispatch_apply(3, dispatch_get_main_queue(), ^(size_t index) {
//
//        
//    });
    
//    和数组配合使用
    NSArray *array = @[@"2b",@"sb",@"ca"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_apply(array.count, queue, ^(size_t index) {
        NSLog(@"我是卧底，要去执行任务了%@",array);
    });
    
    
    
}

//sync和Async的区别
- (IBAction)differectButtonDidClicked:(UIButton *)sender {
    
    
//    async不等block执行完就去执行下面的代码
//    sync会等block执行完之后  才会去执行那个block外面的代码
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"第一个任务");
    });
    NSLog(@"gege");
    dispatch_async(queue, ^{
        NSLog(@"第二个任务");
    });
    NSLog(@"haha");
    
    dispatch_sync(queue, ^{
        NSLog(@"第3个任务");
    });
    NSLog(@"sb");
    dispatch_sync(queue, ^{
        NSLog(@"第4个任务");
    });
    NSLog(@"2b");
    
}

void function (void *context)
{
    printf("啊啊啊");
}

- (IBAction)functionPointerButton:(UIButton *)sender {
    
//    第一个参数  ：队列  第二个参数：函数参数的内容  第三个参数：函数
//    dispatch_async_f(<#dispatch_queue_t queue#>, <#void *context#>, <#dispatch_function_t work#>)
//    对于GCD里面的函数要求
//    1、返回值必须是void  参数类型必须是void*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async_f(queue, "23b", function);
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
