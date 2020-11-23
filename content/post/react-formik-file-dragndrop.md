---
title: "React/Formikでファイルのドラッグアンドドロップ"
slug: react-formik-file-dragndrop
date: 2020-10-31T16:54:36+09:00
draft: false
author: sakamossan
---

Formikに渡すコンポーネントはこんな感じのをつくる

- ドラッグアンドドロップを捕捉するためのイベントは `onDragOver`, `onDragLeave`
- Formikは `input[type=file]` に対応していないので `onChange` で捕捉する
    - [react redux - ReactJS: How to handle Image / File upload with Formik? - Stack Overflow](https://stackoverflow.com/questions/56149756/reactjs-how-to-handle-image-file-upload-with-formik)
- 


```ts
const { setStatus, status } = props;
const { isFileDragging } = status;
return (
    <label
        className={classNames("dropzone", { isFileDragging })}
        onDragOver={() =>
            setStatus({ ...status, isFileDragging: true })
        }
        onDragLeave={() =>
            setStatus({ ...status, isFileDragging: false })
        }
    >
        <input
        name="file"
        type="file"
        onChange={async (event: any) => {
            if (event.currentTarget.files) {
                await props.setFieldValue(
                    "file",
                    event.currentTarget.files[0]
                );
                await props.submitForm();
            }
        }}
        />
    </label>
)
```

## css

ドラッグアンドドロップできる領域を作るcssについては以下の記事が参考になった

- [javascript - Drag and drop a file on label - Stack Overflow](https://stackoverflow.com/questions/49971247/drag-and-drop-a-file-on-label/49972384#49972384)

```css
.dropzone {
  width: 600px;
  height: 180px;
  line-height: 180px;
  border-style: dotted;
  border-width: 2px;
  border-color: #ccc;
  color: #ccc;
  text-align: center;

  position: relative;
  input[type=file] {
    opacity: 0;
    height: 100%;
    width: 100%;
    display: block;
  }
}
```

こんなロジックでCSSを定義するようだ

- labelの中にinput要素を入れる
- label要素を
    - position: relative;
        - 子要素で100%を指定しても親要素を超えなくなる
- input要素を 
    - labelの領域 = input[type=file]の領域 となるようする
        - height: 100%;
        - width: 100%;    


### classNames

動的にclassNameを変更するときは `classNames` パッケージが使いやすい

- [JedWatson/classnames: A simple javascript utility for conditionally joining classNames together](https://github.com/JedWatson/classnames)

