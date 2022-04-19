#!/usr/bin/env bash
function help {
    echo "doc"
    echo "-s                 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比"
    echo "-p                 统计不同场上位置的球员数量、百分比"
    echo "-n                 名字最长的球员是谁？名字最短的球员是谁？"
    echo "-a                 年龄最大的球员是谁？年龄最小的球员是谁？"
    echo "-h                 帮助文档"
}

# 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
function task2-1 {
    awk -F "\t" '
        BEGIN {a=0; b=0; c=0;}
        $6!="Age" {
            if($6>=0&&$6<20) {a++;}
            else if($6<=30) {b++;}
            else {c++;}
        }
        END {
            sum=a+b+c;
            printf("Age\tCount\tPercentage\n");
            printf("小于20\t%d\t%f%%\n",a,a*100.0/sum);
            printf("20到30之间\t%d\t%f%%\n",b,b*100.0/sum);
            printf("大于30\t%d\t%f%%\n",c,c*100.0/sum);
        }' worldcupplayerinfo.tsv
}

# 统计不同场上位置的球员数量、百分比
function task2-2 {
    awk -F "\t" '
        BEGIN {sum=0}
        $5!="Position" {
            pos[$5]++;
            sum++;
        }
        END {
            printf("    Position\tCount\tPercentage\n");
            for(i in pos) {
                printf("%13s\t%d\t%f%%\n",i,pos[i],pos[i]*100.0/sum);
            }
        }' worldcupplayerinfo.tsv
}

# 名字最长的球员是谁？名字最短的球员是谁？
function task2-3 {
    awk -F "\t" '
        BEGIN {max=-1; min=1000;}
        $9!="Player" {
            len=length($9);
            names[$9]=len;
            max=len>max?len:max;
            min=len<min?len:min;
        }
        END {
            for(i in names) {
                if(names[i]==max) {
                    printf("The longest name is %s\n", i);
                } else  if(names[i]==min) {
                    printf("The shortest name is %s\n", i);
                }
            }
        }' worldcupplayerinfo.tsv
}

# 年龄最大的球员是谁？年龄最小的球员是谁？
function task2-4 {
    awk -F "\t" '
        BEGIN {max=-1; min=1000;}
        NR>1 {
            age=$6;
            names[$9]=age;
            max=age>max?age:max;
            min=age<min?age:min;
        }
        END {
            printf("The oldest age is %d, whose name is\n", max);
            for(i in names) {
                if(names[i]==max) { printf("%s\n", i); }
            }
            printf("The youngest age is %d, whose name is\n", min);
            for(i in names) {
                if(names[i]==min) { printf("%s\n", i); }
            }
        }' worldcupplayerinfo.tsv
}

# 测试代码
# echo "============================================"
# task2-1
# echo "============================================"
# task2-2
# echo "============================================"
# task2-3
# echo "============================================"
# task2-4


while [ "$1" != "" ];do
    case "$1" in
        "-s")
            task2-1
            exit 0
            ;;
        "-p")
            task2-2
            exit 0
            ;;
        "-n")
            task2-3
            exit 0
            ;;
        "-a")
            task2-4
            exit 0
            ;;
        "-h")
            help
            exit 0
            ;;
    esac
done