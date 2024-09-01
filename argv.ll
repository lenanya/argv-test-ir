target triple = "x86_64-pc-linux-gnu"

@.str = constant [4 x i8] c"%s\0A\00"

define i32 @main(i32 noundef %oargc, ptr noundef %oargv) {
  %argc = alloca i32
  %argv = alloca ptr
  %cntr = alloca i32
  store i32 %oargc, ptr %argc
  store ptr %oargv, ptr %argv
  store i32 1, ptr %cntr
  br label %loop

loop:                                                
  %cntr1 = load i32, ptr %cntr
  %argc1 = load i32, ptr %argc
  %ext = icmp slt i32 %cntr1, %argc1
  br i1 %ext, label %body, label %end

body:                                               
  %argv1 = load ptr, ptr %argv
  %cntr2 = load i32, ptr %cntr
  %cntr2i64 = sext i32 %cntr2 to i64
  %argv1i = getelementptr inbounds ptr, ptr %argv1, i64 %cntr2i64
  %argv1i1 = load ptr, ptr %argv1i
  call i32 (ptr, ...) @printf(ptr noundef @.str, ptr noundef %argv1i1)
  br label %inc

inc:                                               
  %cntr3 = load i32, ptr %cntr
  %cntr3i = add nsw i32 %cntr3, 1
  store i32 %cntr3i, ptr %cntr
  br label %loop

end:                                               
  ret i32 0
}

declare i32 @printf(ptr noundef, ...)
