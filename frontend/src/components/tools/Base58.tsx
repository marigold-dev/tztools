import axios from 'axios';
import React, { useState } from 'react';

function Base58() {
  const [result, setResult] = useState("");
  const [input, setInput] = useState("");

  const onSetResult = async (text:string) => {
      axios.get<string>(
        `${process.env["REACT_APP_BACKEND"]}/base58/encode/${text}`
      ).then(res =>{
        setResult(res.data);
      })
      .catch(error => {
        console.log(error)
        setResult(error.message);
      });
  }

  return (
    <div className='flex justify-center w-screen dark:bg-slate-500  '>
        <div className="flex bg-white justify-between dark:bg-slate-800 rounded-lg px-6 py-8 ring-1 ring-slate-900/5 shadow-xl w-11/12 h-5/6 mt-8 flex-col">
          <h1 className="text-slate-900 dark:text-white mt-0 text-3xl font-medium tracking-tight">Base58</h1>
          <p className="text-slate-500 dark:text-slate-400 mt-2 text-lg">
              Encode or Decode Base 58 Text</p>

          <textarea id="input" rows={4} onChange={(i) => setInput(i.target.value)} className="mt-8 block p-2.5 w-full h-2/5 text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Your input..."></textarea>
          
          <span className='flex space-x-5'>
            <button type="submit" onClick={() => onSetResult(input)} className="flex my-3 w-1/2 items-center py-2.5 px-4 text-xs font-medium text-center justify-center text-white bg-blue-700 rounded-lg focus:ring-4 focus:ring-blue-200 dark:focus:ring-blue-900 hover:bg-blue-800">
                Encode
            </button>
            <button type="submit" onClick={() => onSetResult(input)} className="flex my-3 w-1/2 items-center py-2.5 px-4 text-xs font-medium text-center justify-center text-white bg-blue-700 rounded-lg focus:ring-4 focus:ring-blue-200 dark:focus:ring-blue-900 hover:bg-blue-800">
                Decode
            </button>
          </span>
          
          <textarea id="result" defaultValue={result} rows={4} className="block p-2.5 w-full h-2/5 text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Your result...">
          </textarea>
        </div>
    </div>
  );
}

export default Base58
