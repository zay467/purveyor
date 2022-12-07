import { ForbiddenException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { UserDto } from './dto';
import * as argon from 'argon2';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  async hash_password(ps: string) {
    return await argon.hash(ps);
  }

  async create_user(userDto: UserDto) {
    const hash = await this.hash_password(userDto.password);
    try {
      const user = await this.prisma.user.create({
        data: {
          ...userDto,
          password: hash,
        },
      });
      return user;
    } catch (error) {
      if (error instanceof PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          throw new ForbiddenException('Email already taken.');
        }
      } else {
        throw error;
      }
    }
  }
}
