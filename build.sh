#!/bin/bash

# Corne 键盘 ZMK 配置构建脚本
# 此脚本用于构建 Corne 键盘的 ZMK 固件

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 函数定义
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  Corne 键盘 ZMK 固件构建脚本${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
}

print_step() {
    echo -e "${GREEN}[步骤 $1]${NC} $2"
}

print_warning() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

print_error() {
    echo -e "${RED}[错误]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[成功]${NC} $1"
}

# 检查依赖
check_dependencies() {
    print_step "1" "检查构建依赖..."
    
    # 检查 west
    if ! command -v west &> /dev/null; then
        print_error "west 命令未找到。请安装 Zephyr SDK。"
        echo "请访问 https://docs.zephyrproject.org/latest/develop/getting_started/index.html"
        exit 1
    fi
    
    # 检查 git
    if ! command -v git &> /dev/null; then
        print_error "git 命令未找到。"
        exit 1
    fi
    
    print_success "依赖检查通过"
}

# 初始化 Zephyr 环境
init_zephyr() {
    print_step "2" "初始化 Zephyr 环境..."
    
    if [ ! -d "zmk" ]; then
        print_warning "ZMK 子模块不存在，正在初始化..."
        west init -l
        west update
    else
        print_success "ZMK 环境已存在"
    fi
}

# 构建固件
build_firmware() {
    print_step "3" "构建固件..."
    
    local side=$1
    if [ "$side" = "left" ] || [ "$side" = "right" ]; then
        print_warning "正在构建 $side 半部分固件..."
        west build -b nice_nano_v2 -- -DSHIELD=corne_romac_"$side"
    else
        print_warning "正在构建默认配置..."
        west build -b nice_nano_v2 -- -DSHIELD=corne_romac
    fi
    
    print_success "固件构建完成"
}

# 清理构建文件
clean_build() {
    print_step "4" "清理构建文件..."
    west build --clean
    print_success "清理完成"
}

# 显示帮助信息
show_help() {
    echo "用法: $0 [选项]"
    echo
    echo "选项:"
    echo "  left        构建左半部分固件"
    echo "  right       构建右半部分固件"
    echo "  clean       清理构建文件"
    echo "  help        显示此帮助信息"
    echo
    echo "示例:"
    echo "  $0          # 构建默认固件"
    echo "  $0 left     # 构建左半部分"
    echo "  $0 right    # 构建右半部分"
    echo "  $0 clean    # 清理构建文件"
}

# 主函数
main() {
    print_header
    
    case "${1:-}" in
        "left")
            check_dependencies
            init_zephyr
            build_firmware "left"
            ;;
        "right")
            check_dependencies
            init_zephyr
            build_firmware "right"
            ;;
        "clean")
            clean_build
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        "")
            check_dependencies
            init_zephyr
            build_firmware
            ;;
        *)
            print_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
    
    echo
    print_success "构建脚本执行完成！"
}

# 执行主函数
main "$@"