import React, { PropsWithChildren } from 'react';
import { Link } from 'react-router-dom';

function SideBar() {
  return (
        <aside className="w-64" aria-label="Sidebar">
          <div className="overflow-y-auto py-4 px-3 bg-gray-50 dark:bg-gray-800 h-screen">
              <ul className="space-y-2">
                <Item>Base58</Item>
                <Item>BlockHash</Item>
                <Item>Blake2B 32bits</Item>
              </ul>
          </div>
        </aside>
  );
}

function Item(props: PropsWithChildren) {

    return ( 
        <li>
            <Link to="/" className="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <span>
                    {props.children}
                </span>
            </Link>
        </li>
    )
}

export default SideBar
