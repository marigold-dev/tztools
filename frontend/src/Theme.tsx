import React, { useState, useEffect } from 'react';
import { ThemeContext, Theme } from './contexts/ThemeContext';

export default function ThemeContextWrapper(props: { children: any; }) {
  const [theme, setTheme] = useState<Theme | 'initializing'>("initializing");

  function toggleTheme() {
    setTheme(theme === "dark" ? "light" : "dark");
  }

  useEffect(() => {
    const isSystemDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    if(isSystemDark && theme === "initializing") {
        setTheme("dark");
    }

    if (theme === 'dark'){
        document.documentElement.classList.add('dark');
        return
    } 

    document.documentElement.classList.remove('dark');
  }, [theme]);

  return (
    <ThemeContext.Provider value={{ theme: theme, toggleTheme: toggleTheme }}>
      {props.children}
    </ThemeContext.Provider>
  );
}