# Farmer reference

一个 Godot 4.7 制作的俯视角农场游戏（原型）。

## 环境要求

- [Godot 4.7](https://godotengine.org/download)（或更新的 4.x 版本）

## 如何运行

1. 克隆仓库：

   ```bash
   git clone <仓库地址>
   ```

2. 用 Godot 打开本项目：

   - 方式一：打开 Godot 编辑器，在项目管理器中点击「导入」，选择本目录下的 `project.godot`。
   - 方式二：命令行直接运行（已安装 Godot 命令行工具）：

     ```bash
     godot --path .
     ```

   首次打开时 Godot 会自动导入资源（重新生成 `.godot/` 缓存目录），稍等片刻即可。

## 操作说明

| 按键 | 功能 |
| --- | --- |
| WASD | 移动 |
| 空格 | 使用工具 / 攻击 |
| E / Q | 切换工具（向前 / 向后） |
| F | 种植 |
| C | 切换种子 |
