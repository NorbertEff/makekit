@echo off
set DEFAULT_LLVM_DIR=%ProgramFiles%\LLVM

set /p MK_LLVM_INSTALL_DIR=LLVM installation directory (default is %DEFAULT_LLVM_DIR%):
if "%MK_LLVM_INSTALL_DIR%" == "" (
	set MK_LLVM_INSTALL_DIR=%DEFAULT_LLVM_DIR%
)
if exist "%MK_LLVM_INSTALL_DIR%" (
	echo ERROR: LLVM is already installed. Removing previous vesion...
	rd /s /q "%MK_LLVM_INSTALL_DIR%"
) else (
	mkdir %MK_LLVM_INSTALL_DIR%
)

:: LLVM
cd %MK_LLVM_INSTALL_DIR%
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

:: Compiler-RT
cd %MK_LLVM_INSTALL_DIR%/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt

:: OpenMP
cd %MK_LLVM_INSTALL_DIR%/projects
svn co http://llvm.org/svn/llvm-project/openmp/trunk openmp

:: clang
cd %MK_LLVM_INSTALL_DIR%/tools
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang

:: clang-tools-extra
cd %MK_LLVM_INSTALL_DIR%/tools/clang/tools
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra

:: LLD
cd %MK_LLVM_INSTALL_DIR%/tools
svn co http://llvm.org/svn/llvm-project/lld/trunk lld

:: Polly Loop Optimizer
cd %MK_LLVM_INSTALL_DIR%/tools
svn co http://llvm.org/svn/llvm-project/polly/trunk polly

:: libc++ and libc++abi
:: cd %MK_LLVM_INSTALL_DIR%/projects
:: svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx
:: svn co http://llvm.org/svn/llvm-project/libcxxabi/trunk libcxxabi

:: Test Suite
:: cd %MK_LLVM_INSTALL_DIR%/projects
:: svn co http://llvm.org/svn/llvm-project/test-suite/trunk test-suite

:: Build LLVM

cd %MK_LLVM_INSTALL_DIR%
mkdir build
cmake llvm -Bbuild -GNinja -DCMAKE_C_COMPILER=clang-cl -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_LINKER=lld-link -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=directory -DLIBOMP_ARCH=x86_64 -DLIBOMP_CXXFLAGS=/D_GNU_SOURCE -DLLVM_ENABLE_ASSERTIONS=OFF -DLIBOMP_HAVE_WEAK_ATTRIBUTE=FALSE
ninja -C build

:: /usr/local
:: %ProgramFiles%/LLVM

exit /b %ERRORLEVEL%
