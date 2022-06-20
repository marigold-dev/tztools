import React from 'react';

function Home() {
  return (
    <div className='flex justify-center w-screen dark:bg-slate-500'>
        <div className="bg-white dark:bg-slate-800 rounded-lg px-6 py-8 ring-1 ring-slate-900/5 shadow-xl w-11/12 h-max mt-8">
        <h1 className="text-slate-900 dark:text-white mt-0 text-9xl font-medium tracking-tight">Tz Tools</h1>
        <p className="text-slate-500 dark:text-slate-400 mt-2 text-lg">
            By Tezos developers, for Tezos developers.
        </p>
        </div>
    </div>  
  );
}

export default Home
