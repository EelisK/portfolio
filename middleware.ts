import { NextResponse, NextRequest } from "next/server";
import logger from "./common/logger";

const logRequest = (request: NextRequest) => {
  const url = new URL(request.url);
  const message = `${request.method} ${url.pathname} ${url.host}`;
  logger.info(message);
};

export function middleware(request: NextRequest) {
  if (process.env.NODE_ENV === "production") {
    logRequest(request);
  }
  return NextResponse.next();
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - static (static files)
     * - favicon.svg (favicon file)
     */
    "/((?!_next|static|favicon.svg).*)",
  ],
};
