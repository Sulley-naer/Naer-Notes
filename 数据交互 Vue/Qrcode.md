# JS二维码创建

```bash
npm install qrcode

npm i @types/qrcode
```

```javascript
//main.js
import QRCode from 'qrcode'
//全局挂载
window.QRCode = QRCode
```

```typescript
import QRCode from 'qrcode';

declare global {
  interface Window {
    QRCode: typeof QRCode;
  }
}

window.QRCode = QRCode;
```
