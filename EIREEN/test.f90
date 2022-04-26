program test
    use vertex_logic_mod,  only: readin_data, check_orientation, check_quadra_decomp, &
                                & triangles_EIRENE, shape_triangles
    implicit none
    integer :: i, j, k
    integer, dimension(:,:), allocatable :: diff
    logical, dimension(:), allocatable :: check_list
    integer, dimension(:), allocatable :: check_list3
    logical :: check_total, test1 = .false., test2 = .false., test3 = .true.
    logical :: check2 = .false.

    call readin_data()

    VERTEX_TWIN_TEST: if (test1) then
        if (.not. allocated(diff)) allocate(diff(shape_triangles(1), 9))
        if (.not. allocated(check_list)) allocate(check_list(shape_triangles(1)))

        do i =  1, shape_triangles(1)
            do j = 1, shape_triangles(2)
                do k = 1, shape_triangles(2)
                    diff(i,(j-1)*3 + k) = abs(triangles_EIRENE(i,j) - triangles_EIRENE(i,k))
                end do 
            end do 
            if (.not. any(diff(i,:) == 1)) print*, triangles_EIRENE(i,:)
        end do

        check_list = any(diff == 1,2)
        check_total = all(check_list)

        !print*, check_list
        !print*, 'TOTAL ', check_total

        if (allocated(diff)) deallocate(diff)
        if (allocated(check_list)) deallocate(check_list)

    end if VERTEX_TWIN_TEST


    DREH_TEST: if (test2) then
        do i = 1, shape_triangles(1)
            check2 = check_orientation(i)
            if (.not. check2) then
                print*, 'Triangle ', i, 'is oriented clockwise!'
                stop
            end if
        end do
        print*, 'All triangles are counterclockwise!'
    end if DREH_TEST

    PAIR_TEST: if (test3) then
        if (.not. allocated(check_list3)) allocate(check_list3(shape_triangles(1)))
        check_list3 = check_quadra_decomp()
        do i = 1, shape_triangles(1)
            print*, 'Triangle ', i
            print*, check_list3(i)
        end do
    end if PAIR_TEST

end program test