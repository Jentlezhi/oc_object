//
//  main.m
//  StructDemo
//
//  Created by Jentle on 2021/9/29.
//

#import <Foundation/Foundation.h>

//结构体数组
struct stu{
    int num;
    char *name;
    char sex;
    float score;
}boy[5] = {
    {101,"Li ping",'M',45},
    {102,"Zhang ping",'M',62.5},
    {103,"He fang",'F',92.5},
    {104,"Cheng ling",'F',87},
    {105,"Wang ming",'M',58}
};

int main(int argc, const char * argv[]) {
    //结构体数组与指针
    struct stu *ps = boy;
    printf("%s\n",(++ps)->name);//Zhang ping
    
    //结构体与指针
    struct stu student1 = {104,"Cheng ling",'F',87};
    struct stu *s = &student1;
    printf("%s\n",s->name);//Cheng ling
    printf("%s\n",(++s)->name);//(\366\277\357\376
    
    return 0;
}
