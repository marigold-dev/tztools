import React from 'react';
import Navbar from '../components/Navbar';
import SideBar from '../components/Sidebar';
import { Outlet } from 'react-router-dom';

function Layout() {
  return (
    <div className="flex h-screen overflow-hidden flex-col">
      <Navbar />

      {/* Content area */}
      <div className="flex flex-row">

        {/* Sidebar */}
        <SideBar/>

        <Outlet />

      </div>

    </div>
  );
}

export default Layout
