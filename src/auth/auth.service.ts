import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthDto } from './dto';
import { JwtService } from '@nestjs/jwt';
import * as argon from 'argon2';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwt: JwtService,
    private config: ConfigService,
  ) {}

  async signin(authDto: AuthDto) {
    const user = await this.prisma.user.findUnique({
      where: {
        email: authDto.email,
      },
    });

    if (!user) throw new ForbiddenException('Incorrect email or password');

    const pwmatch = await argon.verify(user.password, authDto.password);

    if (!pwmatch) throw new ForbiddenException('Incorrect Password');

    return {
      access_token: await this.generate_token({
        sub: user.id,
        email: user.email,
        role: user.role,
        type: 'access',
      }),
      refresh_token: await this.generate_token(
        {
          sub: user.id,
          email: user.email,
          role: user.role,
          type: 'refresh',
        },
        '24h',
      ),
    };
  }

  async generate_token(
    payload: { sub: number; email: string; role: string; type: string },
    expiresIn: string = '15m',
  ): Promise<string> {
    const secret = this.config.get('JWT_SECRET');

    const token = await this.jwt.signAsync(payload, {
      expiresIn,
      secret,
    });
    return token;
  }
}
