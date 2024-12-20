LUAJIT_PATH = C:\LuaJIT
LUA_WINDOWS_PATH = C:\Program Files (x86)\Lua\5.1
TARGET = two_to_ten
SRC = two_to_ten.lua
BUILD_DIR = build
WEB_SERVER_PORT = 8080

# Цели
all: linux windows web

# Linux
linux:
	@echo "Preparing for Linux..."
	sudo apt-get update && sudo apt-get install -y lua5.4  # Install Lua interpreter
	@echo "End of installation..."
	@echo "Creating Linux build..."
	mkdir -p $(BUILD_DIR)/linux
	cp $(SRC) $(BUILD_DIR)/linux/$(SRC)
	@echo "Linux build created at $(BUILD_DIR)/linux/"
	@echo "To run the game in Linux, use the command 'lua $(BUILD_DIR)/linux/$(SRC)'"


# Windows
windows:
	@echo "Preparing for Windows..."
	mkdir -p $(BUILD_DIR)/windows
	cp $(SRC) $(BUILD_DIR)/windows/$(SRC)
	@if exist "$(LUA_WINDOWS_PATH)\exelua.exe" ( \
        echo "Creating Windows executable using exelua..." && \
		"$(LUA_WINDOWS_PATH)\exelua.exe" $(BUILD_DIR)/windows/$(SRC)  \
	) else ( \
		echo "exelua not found. Copy lua script to windows machine and run using 'lua $(BUILD_DIR)/windows/$(SRC)'"\
	)
	@echo "Windows build created at $(BUILD_DIR)/windows/"


# Web
web:
	@echo "Installing the necessary dependencies for Web..."
	sudo apt-get update
	sudo apt-get install -y git build-essential nodejs npm
	sudo npm install -g http-server
	@echo "Dependencies installed."
	@echo "Setting up Emscripten SDK (Optional)..."
	cd .. && git clone https://github.com/emscripten-core/emsdk.git || true # Optional, for more advanced web builds.
	cd ../emsdk && ./emsdk install latest && ./emsdk activate latest  # Optional
	@echo "Emscripten SDK setup complete." # Optional
	@echo "Compiling for Web (Using simple copy for demonstration)..."
	mkdir -p $(BUILD_DIR)/web
	cp $(SRC) $(BUILD_DIR)/web/$(SRC) # Copy Lua script
    @echo "Web build created at $(BUILD_DIR)/web/"
    @echo "To run in browser, use a javascript lua interpreter or copy the file to online interpreter."
	@echo "Starting a local server (Optional, for testing)..."
    cd $(BUILD_DIR)/web && http-server -p $(WEB_SERVER_PORT) # Optional
	@echo "Server stopped."

# Clean
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)
	@echo "Clean completed."