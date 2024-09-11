import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';  // Asegúrate de que este archivo existe o elimina esta línea si no lo necesitas
import App from './App';  // Esta importación debe apuntar al archivo `App.js` en `src`

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
