#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ricardo/Desktop/autonomousDrivingCourse/src/turtlebot3_teleop"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ricardo/Desktop/autonomousDrivingCourse/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ricardo/Desktop/autonomousDrivingCourse/install/lib/python2.7/dist-packages:/home/ricardo/Desktop/autonomousDrivingCourse/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ricardo/Desktop/autonomousDrivingCourse/build" \
    "/usr/bin/python2" \
    "/home/ricardo/Desktop/autonomousDrivingCourse/src/turtlebot3_teleop/setup.py" \
     \
    build --build-base "/home/ricardo/Desktop/autonomousDrivingCourse/build/turtlebot3_teleop" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ricardo/Desktop/autonomousDrivingCourse/install" --install-scripts="/home/ricardo/Desktop/autonomousDrivingCourse/install/bin"
