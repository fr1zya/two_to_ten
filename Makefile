# Общие настройки
GCC=gcc
CFLAGS=-Wall -Wextra -O2
LUA_INTERPRETER=lua
TARGET=two-to-ten
SRC=two-to-ten.lua
BUILD_DIR=build
LUA_DIR=lua-5.1.5
WEB_SERVER_PORT=8080
WASM_LUA_URL = "https://raw.githubusercontent.com/jtiai/wasm_lua/main/wasm_lua.js"

# Цели
all: linux windows web

# Linux
linux:
	@echo "Running the game on Linux..."
	mkdir -p $(BUILD_DIR)/linux
	cp $(SRC) $(BUILD_DIR)/linux/
	$(LUA_INTERPRETER) $(BUILD_DIR)/linux/$(SRC)
	@echo "Game execution complete on Linux."

# Windows
windows:
	@echo "Preparing to run the game on Windows..."
	if not exist $(BUILD_DIR)\windows mkdir $(BUILD_DIR)\windows
	copy $(SRC) $(BUILD_DIR)\windows\

	@echo Checking for lua.exe in PATH...
	where lua.exe >nul 2>&1
	if %ERRORLEVEL% EQU 0 (
		@echo lua.exe found in PATH.
		$(LUA_INTERPRETER) $(BUILD_DIR)\windows\$(SRC)
	) else (
		@echo lua.exe not found in PATH. Please install Lua for Windows and add it to your PATH.
		exit /b 1
	)

	@echo "Game execution complete on Windows."
	@echo "Remember that you need lua.exe in the path to run the script on Windows."

# Web
web:
	@echo "Setting up Web version..."
	if not exist $(BUILD_DIR)\web mkdir $(BUILD_DIR)\web  # Ensure the web directory exists

	if not exist wasm_lua.js (
		echo wasm_lua.js not found. Please ensure it is in the current directory.
		exit /b 1
	)

	copy wasm_lua.js $(BUILD_DIR)\web\  # Копирование локального файла wasm_lua.js

	cd $(BUILD_DIR)\web && (
		copy ../../$(SRC) main.lua

		echo ^\
<!DOCTYPE html>^\
<html lang='en'>^\
<head>^\
    <meta charset='UTF-8'>^\
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>^\
    <title>$(TARGET)</title>^\
</head>^\
<body>^\
    <script src='wasm_lua.js'></script>^\
    <script>^\
        fetch('main.lua')^\
            .then(response => response.text())^\
            .then(luaCode => {^\
                wasm_lua.init().then(() => wasm_lua.loadScript(luaCode));^\
            });^\
    </script>^\
</body>^\
</html> > index.html
	)

	cd $(BUILD_DIR)\web && start http-server

	@echo "WebAssembly setup completed. Files are in $(BUILD_DIR)\web/"
	
clean:
	rm -rf $(BUILD_DIR)