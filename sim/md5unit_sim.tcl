onerror {resume}

add wave /md5unit_tb/clk
add wave /md5unit_tb/reset
add wave /md5unit_tb/start
add wave /md5unit_tb/digest0
add wave /md5unit_tb/done0
add wave {/md5unit_tb/md5/cc_sdata[0]}
add wave {/md5unit_tb/md5/cc_kdata[0]}
add wave {/md5unit_tb/md5/cc_iaddr[0]}
add wave {/md5unit_tb/md5/cc_gaddr[0]}
add wave {/md5unit_tb/md5/mccgen[0]/cc/areg}
add wave {/md5unit_tb/md5/mccgen[0]/cc/breg}
add wave {/md5unit_tb/md5/mccgen[0]/cc/creg}
add wave {/md5unit_tb/md5/mccgen[0]/cc/dreg}
add wave {/md5unit_tb/md5/mccgen[0]/cc/adds}
add wave {/md5unit_tb/md5/mccgen[0]/cc/rotated}
add wave {/md5unit_tb/md5/mccgen[0]/cc/step}
add wave {/md5unit_tb/md5/mccgen[0]/cc/stage}
add wave {/md5unit_tb/md5/mccgen[0]/cc/adda}
add wave {/md5unit_tb/md5/mccgen[0]/cc/addb}
add wave {/md5unit_tb/md5/mccgen[0]/cc/t0}
add wave {/md5unit_tb/md5/mccgen[0]/cc/t1}

run 5600 ns
