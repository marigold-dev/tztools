import React, { PropsWithChildren } from 'react';
import { Link } from 'react-router-dom';

function SideBar() {
  return (
        <aside className="w-64" aria-label="Sidebar">
          <div className="overflow-y-auto py-4 px-3 bg-gray-50 dark:border-gray-600 dark:bg-gray-800 h-screen">
              <ul className="space-y-2">
                <ItemCategory>Tezos</ItemCategory>
                <Item to="/block_hash">Tezos Block Hash</Item>
                <ItemCategory>Encryption</ItemCategory>
                <Item to="/blake2b">Blake2B 32bits</Item>
                <Item to="/ed25519">ED25519</Item>
                <ItemCategory>Encoding</ItemCategory>
                <Item to="/base58">Base58</Item>
                <ItemCategory>Integration</ItemCategory>
                <Item to="/api">API</Item>
              </ul>
          </div>
        </aside>
  );
}

function ItemCategory(props: PropsWithChildren) {

    return ( 
        <li>
            <h5 className="mb-2 text-sm font-semibold tracking-wide text-gray-900 uppercase lg:text-xs dark:text-white">
                <span>
                    {props.children}
                </span>
            </h5>
        </li>
    )
}

function Item(props: PropsWithChildren<{to:string}>) {

    return ( 
        <li>
            <Link to={props.to} className="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700">
                <span>
                    {props.children}
                </span>
            </Link>
        </li>
    )
}

export default SideBar
