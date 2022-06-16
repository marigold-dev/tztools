import React, { useEffect } from 'react';
import {
  Route,
  Routes,
  useLocation
} from "react-router-dom";

import './App.css';
import Base58 from './components/tools/Base58';
import Blake2B from './components/tools/Blake2B';
import BlockHash from './components/tools/BlockHash';
import Home from './components/tools/Home';
import Layout from './components/Layout';
import { QueryClient, QueryClientProvider } from 'react-query';
import API from './components/tools/API';

function App() {

  const location = useLocation();
  
  const queryClient = new QueryClient()


  useEffect(() => {
    document.querySelector('html')!.style.scrollBehavior = 'auto'
    window.scroll({ top: 0 })
    document.querySelector('html')!.style.scrollBehavior = ''
  }, [location.pathname]); // triggered on route change

  return (
    <div>
     <QueryClientProvider client={queryClient}>
        <Routes>
          <Route path="/" element={<Layout />}>
            <Route path="/" element={<Home />}/>
            <Route path="/base58" element={<Base58 />} />
            <Route path="/blake2b" element={<Blake2B />} />
            <Route path="/block_hash" element={<BlockHash />} />
            <Route path="/api" element={<API />} />
          </Route>
        </Routes>
     </QueryClientProvider>
    </div>
  );
}

export default App;
