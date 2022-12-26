import ReactDOM from 'react-dom/client'
import React from "react";
import Router from "./controller/Router";
import { BrowserRouter} from 'react-router-dom';
import './index.css'

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <BrowserRouter>
      <Router />
    </BrowserRouter>
  </React.StrictMode>
)
