#!/bin/sh

sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

sed -i "s/cgroup-driver=systemd/cgroup-driver=cgroupfs/g" /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf