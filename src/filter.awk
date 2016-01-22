BEGIN {
    flag=0
}

/^={10}/ {
    if(flag == 1) {
	flag = 0;
	print;
    } else {
	flag = 1;
    }
}

/^=+>/ || flag == 1 {
    print;
}
