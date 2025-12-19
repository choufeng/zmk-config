# Corne 键盘 ZMK 配置

这是为 Corne 键盘设计的 ZMK（Zephyr 键盘映射器）配置文件。

## 键盘规格

- **键盘型号**: Corne (也称为 Crkbd)
- **布局**: 6x4 分体式布局
- **主控芯片**: Nice! Nano v2
- **固件**: ZMK

## 文件结构

```
zmk-config/
├── CMakeLists.txt           # ZMK 项目根配置文件
├── west.yml                # West 清单文件
├── build.sh                # 构建脚本
└── config/
    ├── corne_romac.dts     # 主设备树文件
    ├── corne_romac.dtsi    # 设备树包含文件
    └── corne_romac.keymap  # 键位映射配置
```

## 键位布局

### 层 0: 默认层 (QWERTY)
```
┌─────────┬─────────┬─────────┬─────────┬─────────┐    ┌─────────┬─────────┬─────────┬─────────┬─────────┐
│   Q     │   W     │   E     │   R     │   T     │    │   Y     │   U     │   I     │   O     │   P     │
├─────────┼─────────┼─────────┼─────────┼─────────┤    ├─────────┼─────────┼─────────┼─────────┼─────────┤
│   A     │   S     │   D     │   F     │   G     │    │   H     │   J     │   K     │   L     │   ;     │
├─────────┼─────────┼─────────┼─────────┼─────────┤    ├─────────┼─────────┼─────────┼─────────┼─────────┤
│   Z     │   X     │   C     │   V     │   B     │    │   N     │   M     │   ,     │   .     │   /     │
├─────────┼─────────┼─────────┼─────────┼─────────┤    ├─────────┼─────────┼─────────┼─────────┼─────────┤
│ Ctrl    │ Alt     │ Shift   │ Space   │  FN     │    │ Enter   │ Space   │ Shift   │ Alt     │ GUI     │
└─────────┴─────────┴─────────┴─────────┴─────────┘    └─────────┴─────────┴─────────┴─────────┴─────────┘
```

### 层 1: 功能层
包含数字键、功能键和符号键。

### 层 2: 导航层
包含方向键和媒体控制键。

### 层 3: 调整层
包含蓝牙设置和系统功能键。

## 快速开始

### 前置要求

1. **安装 Zephyr SDK**:
   ```bash
   # Ubuntu/Debian
   sudo apt install python3 python3-pip python3-venv ninja-build gcc gcc-multilib

   # macOS
   brew install ninja dfu-util
   ```

2. **安装 west 工具**:
   ```bash
   pip3 install west
   ```

### 构建固件

1. **克隆此仓库**:
   ```bash
   git clone <your-repo-url>
   cd zmk-config
   ```

2. **初始化 Zephyr 环境**:
   ```bash
   west init -l
   west update
   ```

3. **构建固件**:
   ```bash
   # 使用构建脚本（推荐）
   ./build.sh

   # 或手动构建
   west build -b nice_nano_v2 -- -DSHIELD=corne_romac
   ```

4. **烧录固件**:
   将生成的 `build/zephyr/zmk.uf2` 文件拖拽到键盘的 UF2 引导分区。

### 分别构建左右半部分

```bash
# 构建左半部分
./build.sh left

# 构建右半部分  
./build.sh right
```

## 蓝牙连接

1. **配对新设备**:
   - 切换到调整层（长按 FN 键）
   - 按 `BT_CLR` 清除所有配对记录
   - 按 `BT_SEL 0/1/2/3/4` 选择蓝牙配置文件

2. **连接设备**:
   - 在设备上搜索蓝牙设备 "Corne Romac"
   - 输入配对码（如果需要）
   - 按任意键完成连接

## 自定义配置

### 修改键位映射

编辑 `config/corne_romac.keymap` 文件来自定义键位布局。

### 修改硬件配置

编辑 `config/corne_romac.dtsi` 文件来修改引脚配置和其他硬件设置。

### 重新编译

修改配置后重新运行构建脚本：
```bash
./build.sh clean
./build.sh
```

## 故障排除

### 常见问题

1. **构建失败**: 检查 west 是否正确安装和配置
2. **无法配对**: 确保键盘在配对模式下，并且设备未连接其他键盘
3. **键位不工作**: 检查硬件连接和引脚配置

### 获取帮助

- [ZMK 官方文档](https://zmk.dev/docs)
- [Zephyr 项目文档](https://docs.zephyrproject.org/)
- [Corne 键盘 GitHub](https://github.com/foostan/crkbd)

## 许可证

此配置基于 ZMK 许可证，遵循 MIT 许可证条款。

## 贡献

欢迎提交 Issue 和 Pull Request 来改进此配置！