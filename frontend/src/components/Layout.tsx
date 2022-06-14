import React from 'react';
import logo from '../logo.svg';
import Navbar from '../components/Navbar';
import SideBar from '../components/Sidebar';
import { Outlet, Route, Routes } from 'react-router-dom';
import Home from '../components/Home';

function Layout() {
  return (
    <div className="flex h-screen overflow-hidden flex-col">
      <Navbar />

      {/* Content area */}
      <div className="flex flex-row">

        {/* Sidebar */}
        <SideBar/>

        <Outlet />

        {/* <div className="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden">
          <header>
            <div className="header">
              <img src={logo} className="App-logo" alt="logo" />
              <p>
                Edit <code>src/App.tsx</code> and save to reload.
              </p>
              
              <h1 className="text-3xl font-bold underline">
                Hello world!
              </h1>

              <a
                className="App-link"
                href="https://reactjs.org"
                target="_blank"
                rel="noopener noreferrer"
              >
                Learn React
              </a>
            </div>
          </header>
        </div> */}
      </div>

    </div>
  );
}

export default Layout
