import { updateSession } from '@/lib/supabase/server'
import { type NextRequest } from 'next/server'

export async function middleware(request: NextRequest) {
  // Check if the request is for admin routes
  if (request.nextUrl.pathname.startsWith('/admin')) {
    return await updateSession(request)
  }

  // For all other routes, just continue
  return
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     * Feel free to modify this pattern to include more paths.
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}
