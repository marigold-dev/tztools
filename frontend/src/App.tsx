import React, { createContext, useEffect } from 'react';
import {
  Route,
  Routes,
  Link,
  useLocation
} from "react-router-dom";

import './App.css';
import Home from './components/Home';
import Layout from './components/Layout';

function App() {

  const location = useLocation();


  useEffect(() => {
    document.querySelector('html')!.style.scrollBehavior = 'auto'
    window.scroll({ top: 0 })
    document.querySelector('html')!.style.scrollBehavior = ''
  }, [location.pathname]); // triggered on route change

  return (
    <div>
      <Routes>

        <Route path="/" element={<Layout />}>

          <Route index element={<Home />} />
          {/* <Route path="*" element={<NoMatch />} /> */}
        </Route>
      </Routes>
    </div>
  );
}

export default App;
