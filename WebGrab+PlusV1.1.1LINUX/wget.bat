if not %3==none set http_proxy=%3
%2wget %1 -t %4 --read-timeout=%5 -O %2wget.dat -o %2wget.log %6 %7
exit