import react from 'react';
import Link from 'next/link';

export default function Navbar() { 
    return (
        <nav className="bg-gray-800 p-4">
        <div className="container mx-auto flex justify-between items-center">
            <div className="text-white text-lg font-bold">My Portfolio</div>
            <ul className="flex space-x-4">
            <li><button className='hover:bg-gray-500/70 w-20 h-8 rounded'><a href="/" className='text-white'>Home</a></button></li>
            <li><button className='hover:bg-gray-500/70 w-20 h-8 rounded'><a href="/about" className='text-white'>About</a></button></li>
            <li><button className='hover:bg-gray-500/70 w-20 h-8 rounded'><a href="/project" className='text-white'>Project</a></button></li>
            <li><button className='hover:bg-gray-500/70 w-20 h-8 rounded'><a href="/contact" className='text-white'>Contact</a></button></li>
            <li><button className='bg-gray-200 hover:bg-white/80 w-20 h-8 rounded'><a href="/register" className='text-black'>Register</a></button></li>
            <li><button className='bg-white hover:bg-white/80 w-20 h-8 rounded'><a href="/login" className='text-black'>Login</a></button></li>
            </ul>
        </div>
        </nav>
    );
}