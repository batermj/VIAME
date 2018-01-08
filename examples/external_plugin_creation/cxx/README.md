Example C++ external module creation.

This example compiles a C++ shared library (.so or .dll) which contains
a loadable VIAME object detector. The difference between this and other
examples is that it can link against on existing VIAME install and is
built outside of the VIAME build chain. In order to build it, you need
to set the VIAME_DIR cmake variable to the location of your VIAME install.