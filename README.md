# 基础

## 路由

gin框架的路由库是基于 [httprouter](https://github.com/julienschmidt/httprouter)

gin可以通过 `Context`的Param方法来获取API参数

## JSON解析

Gin 使用 encoding/json 作为默认的 json 包，但是你可以在编译中使用标签将其修改为 jsoniter。

```bash
$ go build -tags=jsoniter .
```