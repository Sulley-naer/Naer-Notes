# github action

> [!TIP]
> action 是github为仓库提供的一种自动化工具，他能接听仓库的变化后执行终端命令

## 自动构建

> [!TIP]
> 用于更新了进行编译检测，对异常代码的自动检测方式

1. 仓库选择action「操作」
2. 新建工作流程，语言模板
3. 根据仓库结构修改「ai」
4. 提交触发自动构建测试

注意后期请修改触发脚本逻辑 当对应项目更新的时候再去编译检测

## CI/CD

> [!TIP]
> 自动构建发布编译文件

1. 由操作指令为仓库文件进行变化，需要用到权限需要开放密钥
2. github>个人设置>开发者选项>个人令牌>精细化>生成令牌
3. 自定义名称>选择期限>设置权限范围>仓库权限>内容>读写
4. 仓库>设置>机密与变量>操作>新建密钥>关键词与替换内容
5. ${{  }} 是Github的语法，支持替换环境变量，支持关键词

```yaml
# 自动脚本名称
name: Java CI with Maven

# 触发方式 main 分支 Server 文件夹下内容变化执行

on:
  push:
    branches: [ "main" ]
    paths:
      - 'Server/**'
  pull_request:
    branches: [ "main" ]
    paths:
      - 'Server/**'

jobs:
  build:

    runs-on: ubuntu-latest
    
    # 配置环境
    steps:
    - uses: actions/checkout@v4
    - name: Set up JDK 17
      uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: 'temurin'
        cache: maven
        
    # 执行其他终端命令
    - name: Build with Maven
      run: mvn -B package --file Server/pom.xml

    # Optional: Uploads the full dependency graph to GitHub to improve the quality of Dependabot alerts this repository can receive
    - name: Update dependency graph
      run: mvn com.github.ferstl:depgraph-maven-plugin:4.0.1:graph -DgraphFormat=json -f Server/pom.xml
```

演示

```yaml
name: CI/CD

# 触发条件 仓库内 主分支的 Server 或 Client 文件变化执行
on:
  push:
    branches: [ "main" ]
    paths:
      - 'Server/**'
      - 'Client/**'
  pull_request:
    branches: [ "main" ]
    paths:
      - 'Server/**'
      - 'Client/**'

jobs:
  build:
    runs-on: ubuntu-latest
    
    # 构建步骤
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Debug path
        run: ls -al

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: 'npm'
          cache-dependency-path: '**/package-lock.json'

      - name: Install frontend dependencies
        working-directory: Client
        run: npm ci

      - name: Build frontend
        working-directory: Client
        run: npm run build

      - name: Zip frontend dist
        run: zip -r frontend-dist.zip dist
        working-directory: Client

      - name: Setup JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
          cache: maven

      - name: Grant execute permission to mvnw
        run: chmod +x ./mvnw
        working-directory: Server

      - name: Build backend
        run: ./mvnw package -DskipTests
        working-directory: Server

      - name: Rename jar for release
        run: mv target/Blog-0.0.1-SNAPSHOT.jar target/Blog-v1.0.${{ github.run_number }}.jar
        working-directory: Server

      - name: Create Release
        id: create_release
        uses: actions/create-release@v1
        with:
          tag_name: v1.0.${{ github.run_number }}
          release_name: Release ${{ github.run_number }}
          draft: false
          prerelease: false
        # 为仓库存入构建完成文件，需要验证权限 可以直接复制密钥 但是明文太危险 使用环境变量替换
        # 自定义环境变量 在上面的仓库设置机密与密钥 自动注入你所添加的 环境变量名和内容
        env:
          GITHUB_TOKEN: ${{ secrets.PAT_TOKEN }}

      #      替换 Blog 关键词替换后端发布前缀
      - name: Upload Backend Jar
        uses: actions/upload-release-asset@v1
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: Server/target/Blog-v1.0.${{ github.run_number }}.jar
          asset_name: Blog-v1.0.${{ github.run_number }}.jar
          asset_content_type: application/java-archive
        env:
          GITHUB_TOKEN: ${{ secrets.PAT_TOKEN }}

      #      替换 Frontend 词 用于修改前端发布前缀
      - name: Upload Frontend Zip
        uses: actions/upload-release-asset@v1
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: Client/frontend-dist.zip
          asset_name: frontend-v1.0.${{ github.run_number }}.zip
          asset_content_type: application/zip
        env:
          GITHUB_TOKEN: ${{ secrets.PAT_TOKEN }}

```
