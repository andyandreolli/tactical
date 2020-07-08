from psutil import virtual_memory as vm
import os



def size_ram_check(fname):

    fsize_gb = os.stat('somefile.txt').st_size

    if fsize_gb > vm().total:
        mem_warning('file size exceeds memory capacity')
    elif fsize_gb > 0.95 * vm().available:
        mem_warning('file size exceeds available space on memory')



def mem_warning(message):

    print('Warning:', message)
    print('This could lead to memory swapping, hence degraded performance.')
    continue_flag = input('Are you sure you want to continue? (y/n) ')

    while not continue_flag[0] == 'y':
        if continue_flag[0] == 'n':
            message = message + '; user chose to terminate execution.'
            raise Exception(message)
        else:
            continue_flag = input('Please enter y(es) or n(o): ')